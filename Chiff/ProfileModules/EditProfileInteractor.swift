//
//  EditProfileInteractor.swift
//  Chiff
//
//  Created by Zakirov Tahir on 05.03.2022.
//

import Foundation

protocol EditProfileInteractorProtocol {
    
}

class EditProfileInteractor: BaseInteractor, EditProfileInteractorProtocol {
    weak var presenter: EditProfilePresenterProtocol?
}
